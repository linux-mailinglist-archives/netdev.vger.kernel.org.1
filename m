Return-Path: <netdev+bounces-293364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC5vGpdZG2oBBgkAu9opvQ
	(envelope-from <netdev+bounces-293364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 23:41:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3606137A3
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 23:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 919C23004DB4
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D93377EAC;
	Sat, 30 May 2026 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1et/tf1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714A366541;
	Sat, 30 May 2026 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780177296; cv=none; b=Rkd3GggIyRooGUFWBhy357/oG/HqrTND5WYAxC8ZSPkdcto4AHNeoxdsk0MmwYQ15+CIY4COMTvfju/46lSxijpdlxnRd640hjd66V3m9RHEOwk8jEE6kC7eqcXhznzDWExvcCGF2zqgsRJjywLr8H0bhplMLroonbOYIYctzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780177296; c=relaxed/simple;
	bh=ous4BKfOB5KVPIWSdXX1iS/qOi2H/nPBJYVK8j6Uyi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs4SKTQLPGeJjPr4C6Cd/GQQf+30hSHufJmrSVNWyZ9pRaqgq9MzXC/1UKNDM7VtzPKgQErL/MBwPt+ZyQCKCKdfZzy6hkXWCrf9xIbwK4MrxVUV949PWFpm/pXUNr4zEqBHR6rPXVr7a/kfvVIKAX4zbnp57ug0T3zbk2HECTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1et/tf1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780177293; x=1811713293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ous4BKfOB5KVPIWSdXX1iS/qOi2H/nPBJYVK8j6Uyi8=;
  b=C1et/tf15qrW3fDsLz+VK6gn5EobqW5OA2Ks5LotL2w7Z4MuvJgv18n+
   7tQrLfSSPI7AgPgm71t62qhpDyMRLxPyY1yaQHAOVFXJN5jbRrc0g9XF5
   4W03IZvFfg2rS0oJC6gcjziU1TYHjAX4BRogzPMsgKNmhvoVMPK1oyN16
   Vce6h1RBopePvs57YO7s0MkoACnP2QbHAbIKkJeV5bbkOBnIUYzBC70Fn
   A6rmd9eWJgU6iVx83LdTJ9xI0+hbwmtiV8ByYkrQjG3G87A0ncYKQsQXs
   mIVnIdSsTnMez8UFcRwx/X4RiI4XtuqLQ5vsT5U7QzdWPamWPLM2o03gz
   Q==;
X-CSE-ConnectionGUID: 2hqeqAb4T962VHLYt0aEwQ==
X-CSE-MsgGUID: MnPSjwgFS06kGp0jRM0V0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="81046635"
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="81046635"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 14:41:33 -0700
X-CSE-ConnectionGUID: Y3QzqPhcRRaAhSmw8ZUbLQ==
X-CSE-MsgGUID: 6LIlfcLcQ8ihz37D6RtLLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="281289966"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2026 14:41:29 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTRQs-000000008v0-2tQL;
	Sat, 30 May 2026 21:41:26 +0000
Date: Sun, 31 May 2026 05:41:17 +0800
From: kernel test robot <lkp@intel.com>
To: Manish Baing <manishbaing2789@gmail.com>, jk@codeconstruct.com.au,
	matt@codeconstruct.com.au
Cc: oe-kbuild-all@lists.linux.dev, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, manishbaing2789@gmail.com
Subject: Re: [PATCH] mctp: serial: replace memset with zero-initialization
Message-ID: <202605310538.R9GEHEYK-lkp@intel.com>
References: <20260530175618.135533-1-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530175618.135533-1-manishbaing2789@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-293364-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,codeconstruct.com.au];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,01.org:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE3606137A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Manish,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.1-rc5 next-20260529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manish-Baing/mctp-serial-replace-memset-with-zero-initialization/20260531-015807
base:   linus/master
patch link:    https://lore.kernel.org/r/20260530175618.135533-1-manishbaing2789%40gmail.com
patch subject: [PATCH] mctp: serial: replace memset with zero-initialization
config: x86_64-buildonly-randconfig-001-20260531 (https://download.01.org/0day-ci/archive/20260531/202605310538.R9GEHEYK-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605310538.R9GEHEYK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605310538.R9GEHEYK-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/mctp/mctp-serial.c: In function 'test_next_chunk_len':
>> drivers/net/mctp/mctp-serial.c:540:28: error: redeclaration of 'devx' with no linkage
     540 |         struct mctp_serial devx = { };
         |                            ^~~~
   drivers/net/mctp/mctp-serial.c:539:28: note: previous declaration of 'devx' with type 'struct mctp_serial'
     539 |         struct mctp_serial devx;
         |                            ^~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_STMFX
   Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
   Selected by [y]:
   - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && HAS_IOMEM [=y]


vim +/devx +540 drivers/net/mctp/mctp-serial.c

   536	
   537	static void test_next_chunk_len(struct kunit *test)
   538	{
   539		struct mctp_serial devx;
 > 540		struct mctp_serial devx = { };
   541		struct mctp_serial *dev = &devx;
   542		int next;
   543	
   544		const struct test_chunk_tx *params = test->param_value;
   545	
   546		memcpy(dev->txbuf, params->input, params->input_len);
   547		dev->txlen = params->input_len;
   548	
   549		for (size_t i = 0; i < MAX_CHUNKS; i++) {
   550			next = next_chunk_len(dev);
   551			dev->txpos += next;
   552			KUNIT_EXPECT_EQ(test, next, params->chunks[i]);
   553	
   554			if (next == 0) {
   555				KUNIT_EXPECT_EQ(test, dev->txpos, dev->txlen);
   556				return;
   557			}
   558		}
   559	
   560		KUNIT_FAIL_AND_ABORT(test, "Ran out of chunks");
   561	}
   562	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

