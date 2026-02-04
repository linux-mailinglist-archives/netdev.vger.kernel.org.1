Return-Path: <netdev+bounces-256675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EUPBUcrg2kxigMAu9opvQ
	(envelope-from <netdev+bounces-256675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:19:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7CE5033
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18E3F3004401
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082473E9F6A;
	Wed,  4 Feb 2026 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOLJHWxN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA882F2905
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203964; cv=none; b=FkPid2EJl0GnP5fpH4YAlv3vg3ZpruWwNFBBxNP33CDmQD0IUenwy4l35M9yi9bsFAudUP+5yb7tYT6SWtqHxfIspIX/iiWQ9+d4y4u/TUm3CtnIM4Fhe0S7sl/bk4kgpgctSjDn7KIk8u8Oiq9UKcnEyIOfGUjIsMxULIqA3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203964; c=relaxed/simple;
	bh=hU1NmMIbpza6IvYi/eawnBfChN1LUcce9O3t3QADs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuSdczUUaN0mST4l8z4OwEAMWLxbe+CjTuyk1VIBY0wAzgnmHNvbLOKGQosyqIIsPNekGAYBveCDlsMBmAtb44aB4ALlXA/3S91RYi11PyL679Ya2t3Clu55qWbzqpJ9UMysan9JeCV8W3EFrUgAECLb3931bwIWL1nrCtKoqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOLJHWxN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770203964; x=1801739964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hU1NmMIbpza6IvYi/eawnBfChN1LUcce9O3t3QADs5Q=;
  b=UOLJHWxNd1aaRt2LE3yNxL5SRmW2tTO01+8Bbxwz2wJzDLuBciFGIgsM
   If31qPi3XGRl+jbckXpmPcYyWKGmWcjff+PUUNxSNcAwq7n9ZKuNYE3nw
   qoSGtdzhAmUW+AREx2377kw7eaS47tYsx6XGORVOtGwCuzVaHPjfjisUv
   14ffUT8yrg74S+SUyqtAPkC/SipPh6XK5E7vj0txAflOhV1jWB3opmNGU
   FWoS4LIw9tbLHz4/TwWgGSYpn4Vbw3EI2S2JV0/9M2f+oveb1IeBdU5VD
   LnjpsXhpcMddInsrkO2MSTjhE79y/SDc8AymRn9yplqrVfcXbGV+uOF22
   w==;
X-CSE-ConnectionGUID: qvV/QHGeQr2u217uJHcDGw==
X-CSE-MsgGUID: FbNZtKm2QzOcxG+XB1C8Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75240511"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="75240511"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 03:19:20 -0800
X-CSE-ConnectionGUID: S9o9F0zgQB2NFJ9l6hkr+Q==
X-CSE-MsgGUID: cBGuI30cQBuf/5Gq3nYu7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="233059381"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Feb 2026 03:19:18 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnaui-00000000hjI-03S3;
	Wed, 04 Feb 2026 11:19:16 +0000
Date: Wed, 4 Feb 2026 19:18:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH net-next v1 7/7] net: wangxun: add pcie error handler
Message-ID: <202602041942.kNt5G253-lkp@intel.com>
References: <20260203075759.5852-8-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203075759.5852-8-jiawenwu@trustnetic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256675-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41C7CE5033
X-Rspamd-Action: no action

Hi Jiawen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiawen-Wu/net-ngbe-move-the-WOL-functions-to-libwx/20260203-160343
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260203075759.5852-8-jiawenwu%40trustnetic.com
patch subject: [PATCH net-next v1 7/7] net: wangxun: add pcie error handler
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260204/202602041942.kNt5G253-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602041942.kNt5G253-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602041942.kNt5G253-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_err.o: in function `wx_pcie_do_recovery':
>> wx_err.c:(.text.unlikely+0x214): undefined reference to `aer_recover_queue'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

